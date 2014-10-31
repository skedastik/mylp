function test_assert(message, result, expectation)
    % Lazy floating point comparison via absolute epsilon. Yes, I'm also using this to check integer values. No harm, no foul.
    eps = 0.0001;
    
    expectation_lo = expectation - eps;
    expectation_hi = expectation + eps;
    
    if (any(result < expectation_lo | result > expectation_hi))
        printf(["[FAIL] > " message "\n"]);
        result
        expectation
    end
end
