use FindBin qw/ $Bin /;
use File::Basename;
use lib ( dirname($Bin). '/db' );

package Schedule::Simple::Schema;
use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_components(qw/Schema::PopulateMore/);
__PACKAGE__->load_namespaces;

1;
