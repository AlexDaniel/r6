package R6;

# VERSION

use Mojo::Base 'Mojolicious';
use R6::Model::RT;

sub startup {
    my $self = shift;
    $self->moniker('R6');
    $self->plugin('Config');
    $self->secrets([ $self->config('mojo_secrets') ]);
    $self->plugin( AssetPack => { pipes => [qw/Sass JavaScript Combine/] } );
    $self->asset->process(
        'app.css' => qw{
            /sass/bootstrap.css
            /sass/main.scss
        },
    );

    $self->asset->process(
        'app.js' => qw{
            /js/main.js
        },
    );

    $self->helper( rt => sub { state $db = R6::Model::RT->new; });


    my $r = $self->routes;
    { # Root routes
        $r->get('/')->to('root#index');
        $r->get('/about')->to('root#about');
        $r->get('/t/:tag')->to('tickets#tag');
        $r->get('/tag/:tag')->to('tickets#tag');

    }


}

1;

__END__

# ABSTRACT: turns baubles into trinkets to make dzil happy