package Schedule::Simple::Schema::Result::Dependency;
use base qw/DBIx::Class::Core/;
__PACKAGE__->table("dependency");
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
__PACKAGE__->set_primary_key("childjobid");

1;
