package SPVM::Regex::Match;

1;

=head1 Name

SPVM::Regex::Match - Regex Matching Result

=head1 Description

The Regex::Match class of L<SPVM> has methods to manipulate a regex matching result.

=head1 Usage

  use Regex::Match;
  
  my $match = Regex::Match->new({success => 1, captures => [(string)"abc", "def"]});
  
  my $cap1 = $match->cap1;
  my $cap2 = $match->cap2;
  my $cpa3 = $match->cap3;

=head1 Fields

=head2 success

C<has success : ro byte;>

If a pattern match is successful, this field is set to 1.

=head2 captures

C<has captures : ro string[];>

The captured strings.

=head2  match_start

C<has match_start : ro int>;

The start offset of the matched string.

=head2 match_length

C<has match_length : ro int>;

The length of the matched string.

=head1 Class Methods

=head2 new

C<static method new : Regex::Match ($options : object[] = undef);>

Creates a new L<Regex::Match> object, and returns it.

Options:

=over 2

=item * C<success> : Int

Sets the C<success> field.

=item * C<match_start> : Int

Sets the C<match_start> field.

=item * C<match_length> : Int

Sets the C<match_length> field.

=item * C<captures> : string[]

Sets the C<captures> field.

=back

Examples:

  my $match = Regex::Match->new({success => 1, captures => [(string)"abc", "def"]});

=head1 Instance Methods

=head2 captures_length

C<method captures_length : int ();>

Gets the length of the L</"captures"> field.

=head2 cap

C<method cap : string ($index : int);>

Returns $match->captures[$index - 1].

=head2 cap1

C<method cap1 : string ();>

Returns $match->cap(1).

=head2 cap2

C<method cap2 : string ();>

Returns $match->cap(2).

=head2 cap3

C<method cap3 : string ();>

Returns $match->cap(3).

=head2 cap4

C<method cap4 : string ();>

Returns $match->cap(4).

=head2 cap5

C<method cap5 : string ();>

Returns $match->cap(5).

=head2 cap6

C<method cap6 : string ();>

Returns $match->cap(6).

=head2 cap7

C<method cap7 : string ();>

Returns $match->cap(7).

=head2 cap8

C<method cap8 : string ();>

Returns $match->cap(8).

=head2 cap9

C<method cap9 : string ();>

Returns $match->cap(9).

=head2 cap10

C<method cap10 : string ();>

Returns $match->cap(10).

=head2 cap11

C<method cap11 : string ();>

Returns $match->cap(11).

=head2 cap12

C<method cap12 : string ();>

Returns $match->cap(12).

=head2 cap13

C<method cap13 : string ();>

Returns $match->cap(13).

=head2 cap14

C<method cap14 : string ();>

Returns $match->cap(14).

=head2 cap15

C<method cap15 : string ();>

Returns $match->cap(15).

=head2 cap16

C<method cap16 : string ();>

Returns $match->cap(16).

=head2 cap17

C<method cap17 : string ();>

Returns $match->cap(17).

=head2 cap18

C<method cap18 : string ();>

Returns $match->cap(18).

=head2 cap19

C<method cap19 : string ();>

Returns $match->cap(19).

=head2 cap20

C<method cap20 : string ();>

Returns $match->cap(20).

=head1 See Also

=over 2

=item * L<Regex|SPVM::Regex>

=item * L<Re|SPVM::Re>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License
