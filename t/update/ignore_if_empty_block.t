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

{
    my $rs = $schema->resultset('User')->new({});

    $form->process( { 
        'name'                     => 'Peter',
        'city.id'                  => '5',
        'addresses_counter'        => '2',
        'addresses_1.address'      => '1 Baker Street',
        'addresses_1.id'           => '',
        'addresses_1.city.name'    => 'London',
        'addresses_1.city.country' => '1',
        'addresses_2.address'      => '2 Mulholland Drive',
        'addresses_2.id'           => '',
        'addresses_2.city.name'    => 'Los Angeles',
        'addresses_2.city.country' => '2',
    } );

    $form->model->update($rs);

    my @cities = map { $_->city } $rs->addresses->all;
    is ($cities[0]->name, 'London');
    is ($cities[1]->name, 'Los Angeles');
}

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
        'addresses_2.address'      => '2 Mulholland Drive',
        'addresses_2.id'           => '',
        'addresses_2.city.name'    => 'Los Angeles',
        'addresses_2.city.country' => '2',
    } );

    $form->model->update($rs);

    my @cities = map { $_->city } $rs->addresses->all;
    is ($cities[0], undef);
    is ($cities[1], undef);
}

done_testing;
