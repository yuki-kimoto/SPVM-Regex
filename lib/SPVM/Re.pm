package SPVM::Re;



1;

=head1 Name

SPVM::Re - Short Description

=head1 Description

Re class in L<SPVM> has methods for Perlish regular expression.

=head1 Usage

  use Re;
  
  my $string = "Hello World"
  my $match = Re->m($string, "^Hellow");
  
  # ABC de ABC
  my $string_ref = ["abc de abc"];
  Re->s($string_ref, ["abc", "g"], "ABC");

=head1 Class Methods

=head2 m

C<static method m : L<Regex::Match|SPVM::Regex::Match> ($string_or_buffer : object of string|L<StringBuffer|SPVM::StringBuffer>, $pattern_and_flags : object of string|string[], $offset_ref : int* = undef, $length : int = -1);>

If the string or the string in the string buffer $string_or_buffer at offset $$offset_ref to the length $length matches the regex(and with flags) $pattern_and_flags.

If matching succeeds, returns a L<Regex::Match|SPVM::Regex::Match> object, otherwise returns undef.

If $length is less than 0, it is set to the string length of $string_or_buffer.

$$offset_ref is updated to the next position if matching succeeds.

=head2 s

C<static method s : L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> ($string_ref_or_buffer : object of string[]|L<StringBuffer|SPVM::StringBuffer>, $pattern_and_flags : object of string|string[], $replace : object of string|L<Regex::Replacer|SPVM::Regex::Replacer>, $offset_ref : int* = undef, $length : int = -1);>

The string referenced or the string in the string buffer $string_or_buffer at offset $$offset_ref to the length $length is replaced with the string of $replace using the regex(and with flags) $pattern_and_flags.

If replacing succeeds, returns a L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> object, otherwise returns undef.

If $length is less than 0, it is set to the string length of $string_or_buffer.

$$offset_ref is updated to the next position if matching succeeds.

The flags in $pattern_and_flags can contains C<"g"> to replace all maching strings.

=head2 split

C<static method split : string[] ($pattern_and_flags : object of string|string[], $string : string, $limit : int = 0)>

Splits $string using $pattern_and_flags, and returns the splited string.

=head1 Copyright & License

Copyright (c) 2025 Yuki Kimoto

MIT License

