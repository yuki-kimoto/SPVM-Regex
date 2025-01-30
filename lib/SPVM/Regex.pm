package SPVM::Regex;

our $VERSION = "0.246";

1;

=encoding utf8

=head1 Name

SPVM::Regex - Regular Expressions

=head1 Description

The Regex class of L<SPVM> has methods for regular expressions.

L<Google RE2|https://github.com/google/re2> is used as the regular expression library.

=head1 Usage

B<Re:>

  use Re;
  
  my $string = "Hello World"
  my $match = Re->m($string, "^Hellow");
  
  # ABC de ABC
  my $string_ref = ["abc de abc"];
  Re->s($string_ref, ["abc", "g"], "ABC");

B<Regex:>

  use Regex;
  
  # Pattern match
  {
    my $re = Regex->new("ab*c");
    my $string = "zabcz";
    my $match = $re->match("zabcz");
  }

  # Pattern match - UTF-8
  {
    my $re = Regex->new("あ+");
    my $string = "いあああい";
    my $match = $re->match($string);
  }

  # Pattern match - Character class and the nagation
  {
    my $re = Regex->new("[A-Z]+[^A-Z]+");
    my $string = "ABCzab";
    my $match = $re->match($string);
  }

  # Pattern match with captures
  {
    my $re = Regex->new("^(\w+) (\w+) (\w+)$");
    my $string = "abc1 abc2 abc3";
    my $match = $re->match($string);
    
    if ($match) {
      my $cap1 = $match->cap1;
      my $cap2 = $match->cap2;
      my $cpa3 = $match->cap3;
    }
  }
  
  # Replace
  {
    my $re = Regex->new("abc");
    my $string = "ppzabcz";
    
    # "ppzABCz"
    my $result = $re->replace($string, "ABC");
  }

  # Replace with a callback and capture
  {
    my $re = Regex->new("a(bc)");
    my $string = "ppzabcz";
    
    # "ppzABbcCz"
    my $result = $re->replace($string, method : string ($re : Regex, $match : Regex::Match) {
      return "AB" . $match->cap1 . "C";
    });
  }

  # Replace global
  {
    my $re = Regex->new("abc");
    my $string = "ppzabczabcz";
    
    # "ppzABCzABCz"
    my $result = $re->replace_g($string, "ABC");
  }

  # Replace global with a callback and capture
  {
    my $re = Regex->new("a(bc)");
    my $string = "ppzabczabcz";
    
    # "ppzABCbcPQRSzABCbcPQRSz"
    my $result = $re->replace_g($string, method : string ($re : Regex, $match : Regex::Match) {
      return "ABC" . $match->cap1 . "PQRS";
    });
  }

  # . - single line mode
  {
    my $re = Regex->new("(.+)", "s");
    my $string = "abc\ndef";
    
    my $match = $re->match($string);
    
    unless ($match) {
      return 0;
    }
    
    unless ($match->cap1 eq "abc\ndef") {
      return 0;
    }
  }

=head1 Details

=head2 More Perlish Pattern Match and Replacement

See L<Re|SPVM::Re> class if you want to use more Perlish pattern match and replacement.

=head1 Dependent Resources

=over 2

=item * L<SPVM::Resource::RE2>

=back

=head1 Regular Expression Syntax

L<Google RE2 Syntax|https://github.com/google/re2/wiki/Syntax>

=head1 Fields

=head1 Class Methods

=head2 new

  static method new : Regex ($pattern : string, $flags : string = undef)

Creates a new L<Regex|SPVM::Regex> object and compiles the regex pattern $pattern with the flags $flags, and retruns the created object.

  my $re = Regex->new("^ab+c");
  my $re = Regex->new("^ab+c", "s");

=head1 Instance Methods

=head2 match

C<method match : L<Regex::Match|SPVM::Regex::Match> ($string_or_buffer : object of string|L<StringBuffer|SPVM::StringBuffer>, $offset_ref : int* = undef, $length : int = -1);>

Performs pattern matching on the substring from the offset $$offset_ref to the length $length of the string or the StringBuffer object $string_or_buffer.

$$offset_ref is updated to the next position.

If the pattern matching is successful, returns a L<Regex::Match|SPVM::Regex::Match> object. Otherwise returns undef.

Exceptions:

$string_or_buffer must be defined. Otherwise an exception is thrown.

The type of $string_ref_or_buffer must be string or StringBuffer. Otherwise an exception is thrown.

$$offset_ref + $length must be less than or equal to the length of $string_or_buffer. Otherwise an exception is thrown.

If the regex is not compiled, an exception is thrown.

=head2 replace

  method replace : L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> ($string_ref_or_buffer : object of string[]|L<StringBuffer|SPVM::StringBuffer>, $replace : object of string|L<Regex::Replacer|SPVM::Regex::Replacer>, $offset_ref : int* = undef, $length : int = -1, $options : object[] = undef)
  
Replaces the substring from the offset $$offset_ref to the length $length of the string $string with the replacement string or callback $replace with the options $options.

If $replace is a L<Regex::Replacer|SPVM::Regex::Replacer> object, the return value of the callback is used for the replacement.

Options:

=over 2

=item * C<global>

This option must be a L<Int|SPVM::Int> object. Otherwise an exception is thrown.

If the value of the L<Int|SPVM::Int> object is a true value, the global replacement is performed.

=back

Exceptions:

$string_ref_or_buffer must be defined. Otherwise an exception is thrown.

$replace must be a string or a L<Regex::Replacer|SPVM::Regex::Replacer> object. Otherwise an exception is thrown.

$$offset_ref must be greater than or equal to 0. Otherwise an exception is thrown.

$$offset_ref + $length must be less than or equal to the length of $string. Otherwise an exception is thrown.

Exceptions of the L<match_forward|/"match_forward"> method can be thrown.

=head2 replace_g

C<method replace_g  : L<Regex::ReplaceInfo|SPVM::Regex::ReplaceInfo> ($string_ref_or_buffer : object of string[]|L<StringBuffer|SPVM::StringBuffer>, $replace : object of string|L<Regex::Replacer|SPVM::Regex::Replacer>, $offset_ref : int* = undef, $length : int = -1, $options : object[] = undef):>

Calls L</replace> method given the same arguments but with C<global> option set to 1, and returns its return value.

=head2 split

C<method split : string[] ($string : string, $limit : int = 0);>

The same as the L<split||SPVM::Fn/"split"> method in the L<Fn|SPVM::Fn> class, but the regular expression is used as the separator.

=head1 Repository

L<SPVM::Regex - Github|https://github.com/yuki-kimoto/SPVM-Regex>

=head1 Author

L<Yuki Kimoto|https://github.com/yuki-kimoto>

=head1 Contributors

=over 2

=item * L<Ryunosuke Murakami|https://github.com/ryun0suke22>

=item * L<greengorcer|https://github.com/greengorcer>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License
