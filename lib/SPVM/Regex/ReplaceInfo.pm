package SPVM::Regex::ReplaceInfo;

1;

=head1 Name

SPVM::Regex::ReplaceInfo - Regex Replacement Information

=head1 Description

Regex::ReplaceInfo class in L<SPVM> represents a regex replacement information.

=head1 Usage

  use Regex::ReplaceInfo;
  
  my $replace_info = Regex::ReplaceInfo->new({replaced_count => 3, match => $match});
  
  my $replaced_count = $replace_info->replaced_count;
  
  my $match = $replace_info->match;
  my $cap1 = $match->cap1;
  my $cap2 = $match->cap2;
  my $cpa3 = $match->cap3;

=head1 Fields

=head2 replaced_count

C<has replaced_count : ro int;>

This field is set to the number of strings replaced the L<replace|SPVM::Regex/"replace"> and L<replace_g|SPVM::Regex/"replace_g"> method in the L<Regex|SPVM::Regex> class.

=head2 match

C<has match : ro L<Regex::Match|SPVM::Regex::Match>;>

This field is set to the result of the pattern match performed by the the L<replace|SPVM::Regex/"replace"> and L<replace_g|SPVM::Regex/"replace_g"> method in the L<Regex|SPVM::Regex> class.

=head1 Class Methods

=head2 new

C<static method new : L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> ($options : object[] = undef);>

Creates a new L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> object, and returns it.

Options:

=over 2

=item * C<replaced_count> : Int

Sets the L</"replaced_count"> field.

=item * C<match> : L<Regex::Match|SPVM::Regex::Match>

Sets the L</"match"> field.

=back

=head1 See Also

=over 2

=item * L<Regex|SPVM::Regex>

=item * L<Re|SPVM::Re>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License
