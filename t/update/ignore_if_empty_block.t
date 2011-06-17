use strict;
use warnings;
use Test::More;

use HTML::FormFu;
use lib 't/lib';
use DBICTestLib 'new_schema';
use MySchema;
use Data::Printer;

my $form = HTML::FormFu->new;

$form->load_config_file('t/update/ignore_if_empty_block.yml');

my $schema = new_schema();

ok 1;

{
    my $rs = $schema->resultset('User')->new({});

    $form->process( { 
        'name'                     => 'Peter',
        #'city.id'                  => '5',
        'addresses_counter'        => '2',
        'addresses_1.address'      => '1 Baker Street',
        'addresses_1.id'           => '',
        'addresses_1.city.name'    => 'London',
        'addresses_1.city.country' => '1',
        'addresses_1.city.id'      => '',
        'addresses_2.address'      => '2 Mulholland Drive',
        'addresses_2.id'           => '',
        #'addresses_2.city.name'    => 'Los Angelis',
        #'addresses_2.city.country' => '2',
    } );

    $form->model->update($rs);

    my $user =  $schema->resultset('User')->find(1);
    my @addresses = $user->addresses->all;
    p $addresses[0]->city;
    #my @cities = map { $_->city } @addresses;
    #p @cities;

}

done_testing;
