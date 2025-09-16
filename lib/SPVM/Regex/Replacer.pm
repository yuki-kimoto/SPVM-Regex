package SPVM::Regex::Replacer;

1;

=head1 Name

SPVM::Regex::Replacer - Callback for Regex Replacement

=head1 Description

Regex::Replacer interface in L<SPVM> is a callback for a regex replacement.

=head1 Usage
  
  use Regex::Replacer;
  use Regex;
  
  my $replacer = (Regex::Replacer)method : string ($re : Regex, $match : Regex::Match) {
    my $replace = "AB" . $match->cap1 . "C";
    return $replace;
  });
  
  my $string = "abc";
  my $re = Regex->new("ab(c)");
  $re->replace_g(my $_ = [$string], $replacer);

=head1 Interface Methods

C<required method : string ($re : Regex, $match : Regex::Match);>

This method is meant to return a replacement string.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License
