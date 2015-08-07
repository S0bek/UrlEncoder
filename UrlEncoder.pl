#!/usr/bin/perl -w

# Copyright (c) 2015 by S0bek.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use Term::ANSIColor;
use URL::Encode qw(url_encode);#qw suivi de methode pour aller recupere juste la fonction en question dans le module

my $url = shift || "http://www.google.com/index.php?mail=toto_\@outlook.com";
my ($suffix , $base , $sep , $encoding);

sub usage {
  die "Usage: $0 http://www.google.com/index.php?mail=my_mail with escape and special chars: mail\@yopmail.com \n";
}

if ($url =~ m!^http\:\/\/(w){3}\.(.)*\.[a-z]{2,3}(\?||\/).*$!) {  #http://www.etc.fr suivi de (? ou /) suivi de la requete

  if ($url =~ m!^http\:\/\/(w){3}\.(.)*\.[a-z]{2,3}(\?).*$!) {
    $sep = "?";
    $suffix = join("" , (split(/\?/ , $url))[1]);
    $base = join("" , (split(/\?/ , $url))[0]);
  } elsif ($url =~ m!^http\:\/\/(w){3}\.(.)*\.[a-z]{2,3}(\/).*$!) {
    $sep = "/";
    $base = join("/" , (split(/\// , $url))[0 , 1 , 2 , 3]);
    $suffix = join("/" , (split(/\// , $url))[4]);
  }

  $encoding = $base . $sep . url_encode($suffix);
  print "URL encodee: ";
  print color 'cyan';
  print "$encoding\n";
  print color 'reset';
  exit 0;

} else {
  usage();
}
