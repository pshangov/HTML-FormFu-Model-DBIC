use strict;
use warnings;
use Test::More tests => 3;

use HTML::FormFu;
use lib 't/lib';
use DBICTestLib 'new_schema';
use MySchema;

my $form = HTML::FormFu->new;

$form->load_config_file('t/default_values/has_one.yml');

my $schema = new_schema();

my $rs = $schema->resultset('Master');

{

    # insert some entries we'll ignore, so our rels don't have same ids
    # test id 1
    my $t1 = $rs->new_result( { text_col => 'xxx' } );
    $t1->insert;

    # test id 2
    my $t2 = $rs->new_result( { text_col => 'yyy' } );
    $t2->insert;

    # user id 1
    my $n1 = $t2->new_related( 'user', { name => 'foo' } );
    $n1->insert;

    # should get test id 3
    my $master = $rs->new_result( { text_col => 'a', } );
    $master->insert;

    # should get note id 2
    my $user = $master->new_related( 'user', { name => 'bar' } );
    $user->insert;
}

{
    my $row = $rs->find(3);

    $form->model->default_values($row);

    is( $form->get_field('id')->render_data->{value},       3 );
    is( $form->get_field('text_col')->render_data->{value}, 'a' );

    my $block = $form->get_all_element( { nested_name => 'user' } );

    is( $block->get_field('name')->render_data->{value}, 'bar' );

}

