package App::Sqitch::GUI::View::Panel::Right;

use utf8;
use Moose;
use namespace::autoclean;
use Wx qw(:allclasses :everything);
use Wx::Event qw<EVT_CLOSE>;

with 'App::Sqitch::GUI::Roles::Element';

has 'panel'   => ( is => 'rw', isa => 'Wx::Panel', lazy_build => 1 );
has 'sizer'   => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'panel_sbs'   => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'panel_fgs'   => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'commands_sbs' => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'commands_fgs' => ( is => 'rw', isa => 'Wx::Sizer', lazy_build => 1 );
has 'btn_status'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_add'     => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_deploy'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_revert'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_verify'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_project' => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_project_sel' => ( is => 'rw', isa => 'Wx::RadioButton', lazy_build => 1 );
has 'btn_change'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_change_sel' => ( is => 'rw', isa => 'Wx::RadioButton', lazy_build => 1);
has 'btn_plan'  => ( is => 'rw', isa => 'Wx::Button', lazy_build => 1 );
has 'btn_plan_sel' => ( is => 'rw', isa => 'Wx::RadioButton', lazy_build => 1);

sub BUILD {
    my $self = shift;

    #-   The main panel

    $self->panel->Show(0);
    $self->panel->SetSizer( $self->sizer );

    #--- Panels

    $self->sizer->Add( $self->panel_sbs, 0, wxEXPAND | wxALL, 5 );
    $self->panel_sbs->Add( $self->panel_fgs,       0, wxEXPAND | wxALL, 5 );
    $self->panel_fgs->Add( $self->btn_project_sel, 0, wxEXPAND,         5 );
    $self->panel_fgs->Add( $self->btn_project,     0, wxEXPAND,         5 );
    $self->panel_fgs->Add( $self->btn_plan_sel,    0, wxEXPAND,         5 );
    $self->panel_fgs->Add( $self->btn_plan,        0, wxEXPAND,         5 );
    $self->panel_fgs->Add( $self->btn_change_sel,  0, wxEXPAND,         5 );
    $self->panel_fgs->Add( $self->btn_change,      0, wxEXPAND,         5 );

    #--- Commands

    $self->sizer->Add( $self->commands_sbs, 1, wxEXPAND | wxALL, 5 );
    $self->commands_sbs->Add( $self->commands_fgs, 1, wxEXPAND | wxALL, 5 );
    $self->commands_fgs->Add( $self->btn_status,   1, wxEXPAND,         0 );
    $self->commands_fgs->Add( $self->btn_add,      1, wxEXPAND,         0 );
    $self->commands_fgs->Add( $self->btn_deploy,   1, wxEXPAND,         0 );
    $self->commands_fgs->Add( $self->btn_revert,   1, wxEXPAND,         0 );
    $self->commands_fgs->Add( $self->btn_verify,   1, wxEXPAND,         0 );

    $self->panel->Show(1);

    return $self;
}

sub _build_panel {
    my $self = shift;

    my $panel = Wx::Panel->new(
        $self->parent,
        -1,
        [ -1, -1 ],
        [ -1, -1 ],
        wxFULL_REPAINT_ON_RESIZE,
        'mainPanel',
    );
    #$panel->SetBackgroundColour(Wx::Colour->new('green'));

    return $panel;
}

sub _build_sizer {
    return Wx::BoxSizer->new(wxVERTICAL);
}

sub _build_commands_sbs {
    my $self = shift;

    return Wx::StaticBoxSizer->new(
        Wx::StaticBox->new( $self->panel, -1, ' Commands ', ),
        wxHORIZONTAL );
}

sub _build_panel_sbs {
    my $self = shift;

    return Wx::StaticBoxSizer->new(
        Wx::StaticBox->new( $self->panel, -1, ' Select Panel ', ),
        wxVERTICAL );
}

sub _build_commands_fgs {
    my $fgsz = Wx::FlexGridSizer->new( 10, 0, 5, 0 ); # 10 rows for buttons
    $fgsz->AddGrowableCol( 0, 1 );
    return $fgsz;
}

sub _build_panel_fgs {
    return Wx::FlexGridSizer->new( 3, 2, 5, 0 ); # 3 rows for buttons
}

sub _build_btn_status {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Status},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_add {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Add},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_deploy {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Deploy},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_revert {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Revert},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_verify {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Verify},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_change_sel {
    my $self = shift;

    return Wx::RadioButton->new(
        $self->panel,
        -1,
        q{ },
        [-1, -1],
        [-1, -1],
    );
}

sub _build_btn_change {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Change},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _build_btn_project_sel {
    my $self = shift;

    return Wx::RadioButton->new(
        $self->panel,
        -1,
        q{ },
        [-1, -1],
        [-1, -1],
    );
}

sub _build_btn_project {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Project},
        [ -1, -1 ],
        [ -1, -1 ],
        wxRB_GROUP,             # first button in group
    );
}

sub _build_btn_plan_sel {
    my $self = shift;

    return Wx::RadioButton->new(
        $self->panel,
        -1,
        q{ },
        [-1, -1],
        [-1, -1],
    );
}

sub _build_btn_plan {
    my $self = shift;

    return Wx::Button->new(
        $self->panel,
        -1,
        q{Plan},
        [ -1, -1 ],
        [ -1, -1 ],
    );
}

sub _set_events { }

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

  Stefan Suciu 2013

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation.

=cut

1;    # End of App::Sqitch::GUI::View::Panel::Right
