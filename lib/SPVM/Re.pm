package SPVM::Re;



1;

=head1 Name

SPVM::Re - More Perlish Regular Expressions

=head1 Description

Re class in L<SPVM> has methods for more Perlish regular expression.

=head1 Usage

  use Re;
  
  # Match
  my $string = "Hello World"
  my $match = Re->m($string, "^Hellow");
  
  # Replace
  my $string = "abc de abc";
  my $replace_info = Re->s(my $_ = [$string], ["abc", "g"], "ABC");
  $string = $_->[0];
  
  # Split
  my $parts = Re->split(" +", $string);

=head1 Class Methods

=head2 m

C<static method m : L<Regex::Match|SPVM::Regex::Match> ($string_value : string|L<StringBuffer|SPVM::StringBuffer>, $pattern_and_flags : string|string[], $offset_ref : int* = undef, $length : int = -1);>

Calls L<Regex#new|SPVM::Regex/"new"> method given $pattern_and_flags. $pattern_and_flags is a pattern string or a string array that contains a pattern and flags.

And the returned L<Regex|SPVM::Regex> object calls L<Regex#match|SPVM::Regex/"match"> method given $string_value, $offset_ref, $offset_ref, $length, and returns its return value.

The L<Regex|SPVM::Regex> object is cached.

Exceptions:

Exceptions thrown by L<Regex#new|SPVM::Regex/"new"> method and L<Regex#match|SPVM::Regex/"match"> cound be thrown.

=head2 s

C<static method s : L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> ($string_ref_value : mutable string|string[]|L<StringBuffer|SPVM::StringBuffer>, $pattern_and_flags : string|string[], $replace : string|L<Regex::Replacer|SPVM::Regex::Replacer>, $offset_ref : int* = undef, $length : int = -1);>

Calls L<Regex#new|SPVM::Regex/"new"> method given $pattern_and_flags. $pattern_and_flags is a pattern string or a string array that contains a pattern and flags.

And the returned L<Regex|SPVM::Regex> object calls L<Regex#replace|SPVM::Regex/"replace"> method given $string_ref_value, $offset_ref, $offset_ref, $length, and returns its return value.

The flags in $pattern_and_flags can contains C<"g"> to L<Regex#replace_g|SPVM::Regex/"replace_g"> method instead of L<Regex#replace|SPVM::Regex/"replace"> method.

The L<Regex|SPVM::Regex> object is cached.

Exceptions:

Exceptions thrown by L<Regex#new|SPVM::Regex/"replace"> method and L<Regex#match|SPVM::Regex/"replace"> cound be thrown.

=head2 split

C<static method split : string[] ($pattern_and_flags : string|string[], $string : string, $limit : int = 0)>

Calls L<Regex#new|SPVM::Regex/"new"> method given $pattern_and_flags. $pattern_and_flags is a pattern string or a string array that contains a pattern and flags.

And the returned L<Regex|SPVM::Regex> object calls L<Regex#split|SPVM::Regex/"split"> method given $string, $limit, and returns its return value.

=head1 See Also

=over 2

L<Regex|SPVM::Regex>

=back

=head1 Copyright & License

Copyright (c) 2025 Yuki Kimoto

MIT License

