use strict;
use warnings;
use Test::More tests => 3;

use HTML::FormFu;
use lib 't/lib';
use DBICTestLib 'new_schema';
use MySchema;
use Data::Printer;

my $form = HTML::FormFu->new;

$form->load_config_file('t/update/ignore_if_empty_block.yml');

my $schema = new_schema();


{
    my $rs = $schema->resultset('Master')->create({});

    $form->process( { text_col => 'test',  'type.type' => 'test type' } );

    $form->model->update($rs);

    is( $rs->text_col, "test" );
    is( $rs->type->type, "test type" );

    p $rs;
}

{
    my $rs = $schema->resultset('Master')->create({});

    $form->process( { text_col => 'test',  'type.type' => '' } );

    $form->model->update($rs);

    is( $rs->text_col, "test" );
    p $rs;
    #is( $rs->type, undef );
}
