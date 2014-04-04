#!/export/home/controlm/perl/bin/perl

use strict;
use warnings;
use Moose;
with qw/MooseX::Workers/;


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

no Moose;

Manager->new->run();

package Scheduler::Schema;
use base qw/DBIx::Class::Schema/;
__PACKAGE__->load_namespaces();

=pod

package DBIx::Class::Result::NodeType;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("nodetype");
__PACKAGE__->add_colums('nodetypeid', {	accessor			=> 'nodetype',
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
my $ins = 
package DBIx::Class::Result::Node;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("node");
__PACKAGE__->add_colums('nodeid', {	accessor			=> 'node',
									data_type			=> 'INT',
									is_nullable			=> 0,
									is_auto_increment	=> 1,
									size				=> 16,
								},
						'name', { data_type		=> 'varchar',
								  size			=> 256,
								  is_nullable	=> 0,
								},
						'type',	{ 

=cut 

package DBIx::Class::Result::Job;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("job");
__PACKAGE__->add_colums(
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

package DBIx::Class::Result::Conditions;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("conditions");
__PACKAGE__->add_colums(
						'conditionid', {
											accessor			=> 'condition',
											data_type			=> 'INT',
											is_nullable			=> 0,
											is_auto_increment	=> 1,
											size				=> 16,
									},
						'parent', {
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						'child', {
									data_type			=> 'INT',
									is_nullable			=> 0,
									size				=> 16,
								},
						);
						




package DBIx::Class::Result::Run;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("run");
__PACKAGE__->add_colums(
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
						'stopped', { data_type			=> 'DATETIME',
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




					
