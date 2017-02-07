#!/usr/bin/env perl
use strict;
use warnings;
use ojo;
use feature 'say';
$/=undef;
my $dom=x(<>);
#my $dom=x(f("wv.html")->slurp);
#my $all=$dom->find("div.resort_box >ul > li")->map("all_text");
#resort_lifts
#resort_elevation
my $elv=$dom->at("#resort_elevation")->find("li")->map("all_text");
my $lifts = $dom->at("#resort_lifts")->find("li")->map(attr=>'title')->join("\n");
my $trn = $dom->at("#resort_terrain")->
      find("li")->
      map("all_text")->
      map(sub{s/\n//g;s/^ +//;s/ +$//;s/  +/\t/;s/  +/ /g; $_})->
      join("\n") ;
my $depth = $dom->find("div[class='sbox sm box_shadow'] > div")->map('all_text');
my @depths= split(/\s+/,$depth->[3]);
my $snowbase=$depths[3]; $snowbase =~ s/"//;
say "snowbase\t$snowbase";

my $cost = $dom->find("table[class=ovv_info] > tr > td")->map('all_text');
my @costs=();
push(@costs, $1) while($cost->[4] =~ m/([0-9.\$]+)/g);
say  "cost\t",$costs[$#costs];

my @a=map {[split(/\s+/,$_)]} @$elv;
say $_->[2],"\t",  $_->[1] for @a;
say $trn;

$lifts=~s/:/\t/g;
say $lifts;

