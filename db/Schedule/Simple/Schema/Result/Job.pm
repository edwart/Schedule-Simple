package Schedule::Simple::Schema::Result::Job;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("job");
__PACKAGE__->add_columns(
						'jobid', {	
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

1;
