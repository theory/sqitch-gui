package App::Sqitch::GUI;

use 5.010001;
use Moose;
use namespace::autoclean;

use App::Sqitch::GUI::Controller;

our $VERSION = '0.003';

has 'controller' => (
    is         => 'rw',
    isa        => 'App::Sqitch::GUI::Controller',
    lazy_build => 1,
);

sub _build_controller {
    return App::Sqitch::GUI::Controller->new();
}

sub run {
    shift->controller->app->MainLoop;
}

__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Stefan Suciu, C<< <stefan@s2i2.ro> >>

=head1 BUGS

None known.

Please report any bugs or feature requests to the author.

=head1 ACKNOWLEDGMENTS

GUI with Wx and Moose heavily inspired/copied from the LacunaWaX
project:

https://github.com/tmtowtdi/LacunaWaX

Copyright: Jonathan D. Barton 2012-2013

Thank you!

=head1 LICENSE AND COPYRIGHT

  Stefan Suciu       2013

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation.

=cut

1;    # End of App::Sqitch::GUI
