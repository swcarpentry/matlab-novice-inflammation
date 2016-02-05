numbers = [1.5, 2.3, 0.7, -0.001, 4.4];
total = 0;

for n = numbers
    assert(n >= 0);
    total = total + n;
end