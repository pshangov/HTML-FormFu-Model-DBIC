package DBICTestLib;
use strict;
use warnings;

use DBI;

use base 'Exporter';

our @EXPORT_OK = qw/ new_schema /;

sub new_schema {
    my $schema = MySchema->connect('dbi:SQLite:dbname=:memory:');
    
    $schema->deploy;
    
    $schema->resultset('Type')->create({ id => 1, type => 'foo' });
    $schema->resultset('Type')->create({ id => 2, type => 'bar' });
    
    $schema->resultset('Type2')->create({ id => 1, type => 'foo' });
    $schema->resultset('Type2')->create({ id => 2, type => 'bar' });
    
    $schema->resultset('Country')->create({ id => 1, name => 'UK' });
    $schema->resultset('Country')->create({ id => 2, name => 'USA' });
    
    return $schema;
}

1;
