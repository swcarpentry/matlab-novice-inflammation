%script test_range_overlap.m

assert(isnan(range_overlap([0.0, 1.0], [5.0, 6.0])));
assert(isnan(range_overlap([0.0, 1.0], [1.0, 2.0])));
assert(isequal(range_overlap([0, 1.0]),[0, 1.0]));
assert(isequal(range_overlap([2.0, 3.0], [2.0, 4.0]),[2.0, 3.0]));
assert(isequal(range_overlap([0.0, 1.0], [0.0, 2.0], [-1.0, 1.0]),[0.0, 1.0]));

