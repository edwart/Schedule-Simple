package Schedule::Simple::Schema::Result::Run;
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

__PACKAGE__->set_primary_key("runid");

1;
