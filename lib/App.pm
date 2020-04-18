package App;
use Mojo::Base 'Mojolicious';
use App::Model::Users;

sub startup {

  my $self = shift;

  $self->secrets(['Mojolicious rocks']);
  $self->helper(users => sub { state $users = App::Model::Users->new });

  # Router
  my $r = $self->routes;
  $r->any('/')->to('login#index')->name('index');

  my $logged_in = $r->under('/')->to('login#logged_in');
  $logged_in->get('/protected')->to('login#protected');

  $r->get('/logout')->to('login#logout');
}

1;