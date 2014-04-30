package List::Permutor::Repeat;
 
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);
 
require Exporter;
 
@ISA = qw(Exporter);
@EXPORT = qw();
$VERSION = '0.01';
 
sub new {
    my $class = shift;
    my $items = [ @_ ];
    bless [ $items, [ (0) x scalar(@$items) ] ], $class;
}
 
sub reset {
    my $self = shift;
    my $items = $self->[0];
    $self->[1] = [ (0) x scalar(@$items) ];
    1;          # No useful return value
}
 
sub peek {
    my $self = shift;
    my $items = $self->[0];
    my $rv = $self->[1];
    @$items[ @$rv ];
}
 
sub next {
    my $self = shift;
    my $items = $self->[0];
    my $rv = $self->[1];     
    return unless @$rv;

    my @next=@$rv;
    my @tail= pop @next;

    while(1){
        if($tail[0]<$#$items){ ## +1
            $tail[0]++;
            $self->[1] = [ @next, @tail ];
            last;
        }elsif(! @next){  ## is max
            $self->[1] = [];
            last;
        }else{   ## this item -> 1 , next item +1
            $tail[0]=0;
            my $n = pop @next;
            unshift @tail, $n;
        }
    }
    return @$items[ @$rv ];
}
 
1;
