package MySchema::Country;
use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components(qw/ Core /);

__PACKAGE__->table("country");

__PACKAGE__->add_columns(
    id        => { data_type => "INTEGER", is_nullable => 0 },
    name      => { data_type => "TEXT", is_nullable => 0 },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->has_one( address => 'MySchema::Address', 'country' );

1;


