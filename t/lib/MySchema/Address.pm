package MySchema::Address;
use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components(qw/ Core /);

__PACKAGE__->table("address");

__PACKAGE__->add_columns(
    id        => { data_type => "INTEGER", is_nullable => 0 },
    user      => { data_type => "INTEGER", is_nullable => 0 },
    my_label  => { data_type => "TEXT", is_nullable => 1 },
    address   => { data_type => "TEXT", is_nullable => 0 },
    country   => { data_type => "INTEGER", is_nullable => 1 },
    type      => { data_type => "INTEGER", is_nullable => 1 },
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to( user => 'MySchema::User' );
__PACKAGE__->belongs_to( country => 'MySchema::Country' );
__PACKAGE__->belongs_to( type => 'MySchema::Type' );

1;

