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
  my $string = "abc de abc";
  Re->s($string, "abc", "ABC", "g");

=head1 Class Methods

=head2 m

C<static method m : Regex::Match ($string_or_buffer : object of string|StringBuffer, $pattern : string, $flags : string = undef, $offset_ref : int* = undef, $length : int = -1);>

=head2 s

C<static method s : Regex::ReplaceInfo ($string_ref_or_buffer : object of string[]|StringBuffer, $pattern : string, $replace : object of string|Regex::Replacer, $flags : string = undef, $offset_ref : int* = undef, $length : int = -1);>

=head2 split

C<static method split : string[] ($pattern : object of string|string[], $flags : string, $string : string, $limit : int = 0);>

=head1 Copyright & License

Copyright (c) 2025 Yuki Kimoto

MIT License

