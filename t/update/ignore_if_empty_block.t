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
        'addresses_counter'        => '2',
        'addresses_1.address'      => 'Sliven',
        'addresses_1.id'           => '',
        'addresses_1.type.type' => '',
        'addresses_2.address'      => 'Sofia',
        'addresses_2.id'           => '',
        'addresses_2.type.type' => 'Bulgaria',
    } );

    $form->model->update($rs);

    #is( $rs->text_col, "test" );
    #is( $rs->type->type, "test type" );

    my @addresses = $rs->addresses;
    my @types = map { $_->country } @addresses;
    p @countries;

}

done_testing;
