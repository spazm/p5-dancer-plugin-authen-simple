use strict;
use warnings;

package Dancer::Plugin::Authen::Simple;
use Dancer ':syntax';
use Dancer::Plugin;
use Module::Load;
use Authen::Simple;

sub authen
{
    my $settings     = plugin_setting();
    my @adapters = ();
    $DB::single = 1;
    foreach my $adapter_name ( keys %{$settings} )
    {
        my $driver = "Authen::Simple::$adapter_name";
        load $driver;
        push @adapters, $driver->new( $settings->{$adapter_name} );
    }
    Authen::Simple->new(@adapters);
}

register authen => \&authen;
register_plugin for_versions => [ 1, 2 ];
