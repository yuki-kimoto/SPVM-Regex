package SPVM::Regex;

our $VERSION = '0.05';

1;

=head1 Name

SPVM::Regex - Regular Expression

=head1 Usage
  
  use Regex;
  
  # Pattern match
  {
    my $re = Regex->new("ab*c");
    my $string = "zabcz";
    my $offset = 0;
    my $match = $re->match_offset($string, \$offset);
  }

  # Pattern match - UTF-8
  {
    my $re = Regex->new("あ+");
    my $string = "いあああい";
    my $offset = 0;
    my $match = $re->match_offset($string, \$offset);
  }

  # Pattern match - Character class and the nagation
  {
    my $re = Regex->new("[A-Z]+[^A-Z]+");
    my $string = "ABCzab";
    my $offset = 0;
    my $match = $re->match_offset($string, \$offset);
  }

  # Pattern match with captures
  {
    my $re = Regex->new("^(\w+) (\w+) (\w+)$");
    my $string = "abc1 abc2 abc3";
    my $offset = 0;
    my $match = $re->match_offset($string, \$offset);
    
    if ($match) {
      my $cap1 = $re->cap1;
      my $cap2 = $re->cap2;
      my $cpa3 = $re->cap3;
    }
  }
  
  # Replace
  {
    my $re = Regex->new("abc");
    my $string = "ppzabcz";
    
    # "ppzABCz"
    my $result = $re->replace($string, 0, "ABC");
    
    my $replace_count = $re->replace_count;
  }

  # Replace with a callback and capture
  {
    my $re = Regex->new("a(bc)");
    my $string = "ppzabcz";
    
    # "ppzABbcCz"
    my $result = $re->replace_cb($string, 0, method : string ($re : Regex) {
      return "AB" . $re->captures->[0] . "C";
    });
  }

  # Replace all
  {
    my $re = Regex->new("abc");
    my $string = "ppzabczabcz";
    
    # "ppzABCzABCz"
    my $result = $re->replace_all($string, 0, "ABC");
  }

  # Replace all with a callback and capture
  {
    my $re = Regex->new("a(bc)");
    my $string = "ppzabczabcz";
    
    # "ppzABCbcPQRSzABCbcPQRSz"
    my $result = $re->replace_all_cb($string, 0, method : string ($re : Regex) {
      return "ABC" . $re->captures->[0] . "PQRS";
    });
  }

  # . - single line mode
  {
    my $re = Regex->new("(.+)", "s");
    my $string = "abc\ndef";
    
    my $offset = 0;
    my $match = $re->match_offset($string, \$offset);
    
    unless ($match) {
      return 0;
    }
    
    unless ($re->captures->[0] eq "abc\ndef") {
      return 0;
    }
  }

=head1 Description

L<Regex|SPVM::Regex> provides regular expression functions.

This module is very unstable compared to other modules. So many changes will be performed.

=head1 Regular Expression Syntax

L<Regex|SPVM::Regex> provides the methodset of Perl regular expression. The target string and regex string is interpretted as UTF-8 string.
  
  # Quantifier
  +     more than or equals to 1 repeats
  *     more than or equals to 0 repeats
  ?     0 or 1 repeats
  {m,n} repeats between m and n
  
  # Regular expression character
  ^    first of string
  $    last of string
  .    all character except "\n"
  
  #    Default mode     ASCII mode
  \d   Not supported    [0-9]
  \D   Not supported    not \d
  \s   Not supported    " ", "\t", "\f", "\r", "\n"
  \S   Not supported    not \s
  \w   Not supported    [a-zA-Z0-9_]
  \W   Not supported    not \w
  
  # Character class and the negatiton
  [a-z0-9]
  [^a-z0-9]
  
  # Capture
  (foo)

B<Regex Options:>

  s    single line mode
  a    ascii mode

Regex options is used by C<new_with_options> method.

  my $re = Regex->new("^ab+c", "sa");

B<Limitations:>

L<Regex|SPVM::Regex> do not support the same set of characters after a quantifier.
      
  # A exception occurs
  Regex->new("a*a");
  Regex->new("a?a");
  Regex->new("a+a");
  Regex->new("a{1,3}a")
      
If 0 width quantifir is between two same set of characters after a quantifier, it is invalid.
      
  # A exception occurs
  Regex->new("\d+\D*\d+");
  Regex->new("\d+\D?\d+");

=head1 Class Methods

=head2 new

  static method new : Regex ($re_str_and_options : string[]...)

Create a new L<Regex|SPVM::Regex> object and compile the regex.

  my $re = Regex->new("^ab+c");
  my $re = Regex->new("^ab+c", "s");

=head1 Instance Methods

=head2 captures

  static method captures : string[] ()

Get the strings captured by "match" method.

=head2  match_start

  static method match_start : int ()

Get the start byte offset of the string matched by "match" method method.

=head2 match_length

  static method match_length : int ()

Get the byte length of the string matched by "match" method method.

=head2 replace_count

  static method replace_count : int ();

Get the replace count of the strings replaced by "replace" or "replace_all" method.

=head2 match

  method match : int ($string : string)

The Alias for the following L<match|/"match_offset"> method.

  my $offset = 0;
  $self->match_offset($string, \$offset);

=head2 match_offset

  method match_offset : int ($string : string, $offset_ref : int*)

Execute pattern matching to the specific string and the start byte offset of the string.

If the pattern match succeeds, C<1> is returned, otherwise C<0> is returned.

You can get captured strings using "captures" method,
and get the byte offset of the matched whole string using "match_start" method,
and get the length of the matched whole string using "match_length" method.

=head2 replace

  method replace  : string ($string : string, $offset : int, $replace : string)

Replace the target string specified with the start byte offset with replace string.

=head2 replace_cb

  method replace_cb  : string ($string : string, $offset : int, $replace_cb : Regex::Replacer)

Replace the target string specified with the start byte offset with replace callback. The callback must have the L<Regex::Replacer|SPVM::Regex::Replacer> interface..

=head2 replace_all

  method replace_all  : string ($string : string, $offset : int, $replace : string)

Replace all of the target strings specified with the start byte offset with replace string.

=head2 replace_all_cb

  method replace_all_cb  : string ($string : string, $offset : int, $replace_cb : Regex::Replacer)

Replace all of the target strings specified with the start byte offset with replace callback. The callback must have the L<Regex::Replacer|SPVM::Regex::Replacer> interface.

=head2 cap1

  method cap1 : string ()

The alias for C<$re->captures->[0]>.

=head2 cap2

  method cap2 : string ()

The alias for C<$re->captures->[1]>.

=head2 cap3

  method cap3 : string ()

The alias for C<$re->captures->[2]>.

=head2 cap4

  method cap4 : string ()

The alias for C<$re->captures->[3]>.

=head2 cap5

  method cap5 : string ()

The alias for C<$re->captures->[4]>.

=head2 cap6

  method cap6 : string ()

The alias for C<$re->captures->[5]>.

=head2 cap7

  method cap7 : string ()

The alias for C<$re->captures->[6]>.

=head2 cap8

  method cap8 : string ()

The alias for C<$re->captures->[7]>.

=head2 cap9

  method cap9 : string ()

The alias for C<$re->captures->[8]>.

=head2 cap10

  method cap10 : string ()

The alias for C<$re->captures->[9]>.
