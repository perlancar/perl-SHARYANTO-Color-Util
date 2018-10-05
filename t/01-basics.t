#!perl

use 5.010;
use strict;
use warnings;
use Test::Exception;
use Test::More 0.98;

use Color::RGB::Util qw(
                           mix_2_rgb_colors
                           mix_rgb_colors
                           rand_rgb_color
                           rgb2grayscale
                           rgb2sepia
                           reverse_rgb_color
                           rgb_luminance
                           tint_rgb_color
                           rgb_distance
                           rgb_diff
                           rgb_is_dark
                           rgb_is_light
                   );

subtest mix_2_rgb_colors => sub {
    dies_ok { mix_2_rgb_colors('0', 'ffffff') };
    is(mix_2_rgb_colors('#ff8800', '#0033cc'), '7f5d66');
    is(mix_2_rgb_colors('ff8800', '0033cc', 0), 'ff8800');
    is(mix_2_rgb_colors('FF8800', '0033CC', 1), '0033cc');
    is(mix_2_rgb_colors('0033CC', 'FF8800', 0.75), 'bf7233');
    is(mix_2_rgb_colors('0033CC', 'FF8800', 0.25), '3f4899');
};

subtest mix_rgb_colors => sub {
    dies_ok { mix_rgb_colors('0', 1) } 'invalid rgb -> dies';
    dies_ok { mix_rgb_colors('000000', 0) } 'total weight zero #1 -> dies';
    dies_ok { mix_rgb_colors('000000', 0) } 'total weight zero #2 -> dies';
    is(mix_rgb_colors('#ff8800', 1, '#0033cc', 1), '7f5d66');
    is(mix_rgb_colors('#ff8800', 2, '#0033cc', 1), 'aa6b44');
    is(mix_rgb_colors('#ff8800', 1, '#0033cc', 2, '000000', 3), '2a2744');
};

subtest rand_rgb_color => sub {
    ok "currently not tested";
};

subtest rgb2grayscale => sub {
    is(rgb2grayscale('0033CC'), '555555');
};

subtest rgb2sepia => sub {
    is(rgb2sepia('0033CC'), '4d4535');
};

subtest reverse_rgb_color => sub {
    is(reverse_rgb_color('0033CC'), 'ffcc33');
};

subtest rgb_luminance => sub {
    ok(abs(0      - rgb_luminance('000000')) < 0.001);
    ok(abs(1      - rgb_luminance('ffffff')) < 0.001);
    ok(abs(0.6254 - rgb_luminance('d090aa')) < 0.001);
};

subtest tint_rgb_color => sub {
    is(tint_rgb_color('#ff8800', '#0033cc'), 'b36e3c');
    is(tint_rgb_color('ff8800', '0033cc', 0), 'ff8800');
    is(tint_rgb_color('FF8800', '0033CC', 1), '675579');
    is(tint_rgb_color('0033CC', 'FF8800', 0.75), '263fad');
    is(tint_rgb_color('0033CC', 'FF8800', 0.25), '0c37c1');
};

subtest rgb_distance => sub {
    is(rgb_distance('000000', '000000'), 0);
    is(rgb_distance('01f000', '04f400'), 5);
    is(rgb_distance('ffff00', 'ffffff'), 255);
};

subtest rgb_diff => sub {
    is(int(rgb_diff("000000","000000", "approx1")),   0);
    is(int(rgb_diff("00ff00","0000ff", "approx1")), 674);
    is(int(rgb_diff("ff0000","000000", "approx1")), 403);
};

subtest rgb_is_dark => sub {
    ok( rgb_is_dark('000000'));
    ok( rgb_is_dark('404040'));
    ok(!rgb_is_dark('a0a0a0'));
    ok(!rgb_is_dark('ffffff'));
};

subtest rgb_is_light => sub {
    ok(!rgb_is_light('000000'));
    ok(!rgb_is_light('404040'));
    ok( rgb_is_light('a0a0a0'));
    ok( rgb_is_light('ffffff'));
};

DONE_TESTING:
done_testing();
