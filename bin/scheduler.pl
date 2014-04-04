#!/export/home/controlm/perl/bin/perl

use strict;
use warnings;
use FindBin qw/ $Bin /;
use File::Basename;
use lib ( dirname($Bin). '/db' );
use Data::Dumper;
use DBI;
use Moose;
with qw/MooseX::Workers/;
use Schedule::Simple::Schema;
my $db = "$Bin/schedule.db";
warn Dumper $db;
my $schema = Schedule::Simple::Schema->connect("dbi:SQLite:uri=$db") or die "Can't connect to db $db: $!";
my $statements = $schema->deployment_statements( )  or die "Can't deploy schema: $!";
print Dumper $statements;
$schema->deploy( { add_drop_table => 1} );
#or die "Can't deploy to db $db: $!";

my $setup_data = [
	{Job => {
			fields => [ qw/ name  command / ],
			data => {
					FileServer	=> [ 'FileServer',	'launchmxj.pl -fs -sync' ],
					XMLServer	=> [ 'XMLServer',	'launchmxj.pl -xmls -sync' ],
					MurexNet	=> [ 'MurexNet',		'launchmxj.pl -mxnet' ],
				},
			},
	},
];

$schema->populate_more($setup_data);

sub run {
}


sub worker_stdout  {  
	my ( $self, $result ) = @_;  #  $result will be a hashref:  {msg => "Hello World"} 
	print $result->{msg};

	#    Note that you can do more than just print the message --
	#    e.g. this is the way to return data from the children for
	#    accumulation in the parent.  
	}
sub worker_stderr  {
	my ( $self, $stderr_msg ) = @_;  #  $stderr_msg will be a string: "Hey look, an error message";
	warn $stderr_msg;
}

#     From here down, this is identical to the previous example.
sub worker_manager_start { warn 'started worker manager' }
sub worker_manager_stop  { warn 'stopped worker manager' }

sub max_workers_reached  { warn 'maximum worker count reached' }
sub worker_error   { shift; warn join ' ', @_;  }
sub worker_finished { warn 'a worker has finished' }
sub worker_started { shift; warn join ' ', @_;  }
sub sig_child      { shift; warn join ' ', @_;  }
sub sig_TERM       { shift; warn 'Handled TERM' }

=for

package Schedule::Simple::Schema;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->load_namespaces() or die "whoops: $!";

package Schedule::Simple::Result::NodeType;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->table("nodetype");
__PACKAGE__->add_columns('nodetypeid', {	accessor			=> 'nodetype',
									data_type			=> 'INT',
									is_nullable			=> 0,
									is_auto_increment	=> 1,
									size				=> 16,
								},
						'name', { data_type		=> 'varchar',
								  size			=> 32,
								  is_nullable	=> 0,
								},
							);

package Schedule::Simple::Result::Node;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->table("node");
__PACKAGE__->add_columns('nodeid', {	accessor			=> 'node',
									data_type			=> 'INT',
									is_nullable			=> 0,
									is_auto_increment	=> 1,
									size				=> 16,
								},
						'name', { data_type		=> 'varchar',
								  size			=> 256,
								  is_nullable	=> 0,
								},
	);

package Schedule::Simple::Result::Job;
use base qw/DBIx::Class::Core/;
__PACKAGE__->load_components(qw/ Ordered /);
__PACKAGE__->table("job");
__PACKAGE__->add_columns(
						'jobid', {	accessor			=> 'job',
									data_type			=> 'INT',
									is_nullable			=> 0,
									is_auto_increment	=> 1,
									size				=> 16,
								},
						'name', { data_type		=> 'varchar',
								  size			=> 256,
								  is_nullable	=> 0,
								},
						'command', { data_type		=> 'varchar',
								  	 size			=> 512,
								  	 is_nullable	=> 0,
									},
						'node', { data_type		=> 'varchar',
								  	 size			=> 32,
								  	 is_nullable	=> 1,
									},
						);
__PACKAGE__->set_primary_key('jobid');

package Schedule::Simple::Result::Dependencies;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("dependencies");
__PACKAGE__->add_columns(
						'parentjobbid', {	accessor			=> 'job',
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						'childjobid', {	accessor			=> 'job',
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						);
package Schedule::Simple::Result::Conditions;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("conditions");
__PACKAGE__->add_columns(
						'conditionid', {
											accessor			=> 'condition',
											data_type			=> 'INT',
											is_nullable			=> 0,
											is_auto_increment	=> 1,
											size				=> 16,
									},
						'name', { data_type		=> 'varchar',
								  size			=> 256,
								  is_nullable	=> 0,
								},
						'jobid', {
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						);
						
package Schedule::Simple::Result::Run;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("run");
__PACKAGE__->add_columns(
						'runid', {	accessor			=> 'job',
									data_type			=> 'INT',
									is_nullable			=> 0,
									is_auto_increment	=> 1,
									size				=> 16,
								},
						'jobid', {	
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						'started', { data_type			=> 'DATETIME',
									 is_nullable 		=> 0,
								 },
						'finished', { data_type			=> 'DATETIME',
									 is_nullable 		=> 1,
								 },
						'pid', 	{ data_type				=> 'INT',
								  is_nullable			=> 0,
								  size					=> 16,
								},
						'status', { data_type			=> 'INT',
								    is_nullable			=> 0,
									size				=> 16,
								},
						'stdout', { data_type			=> 'varchar',
									size				=> 256,
								  	is_nullable			=> 1,
								},
						'stderr', { data_type			=> 'varchar',
									size				=> 256,
								  	is_nullable			=> 1,
								},
						);
=cut
