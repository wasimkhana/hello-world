"""Test cases for the main module."""
import unittest
import io
import sys

from app.main import (
    get_hello_message, 
    calculate_rectangle_area, 
    is_prime, 
    main
)

class TestMainModule(unittest.TestCase):
    """Comprehensive test cases for main module functionality."""
    
    def test_get_hello_message(self):
        """Test that the hello message function returns the expected string."""
        self.assertEqual(get_hello_message(), "Hello, World!")
    
    def test_calculate_rectangle_area(self):
        """Test rectangle area calculation."""
        # Test standard rectangle
        self.assertAlmostEqual(calculate_rectangle_area(5, 3), 15)
        
        # Test zero dimensions
        self.assertAlmostEqual(calculate_rectangle_area(0, 10), 0)
        
        # Test negative dimension raises ValueError
        with self.assertRaises(ValueError):
            calculate_rectangle_area(-1, 5)
    
    def test_is_prime(self):
        """Test prime number identification."""
        # Test known prime numbers
        prime_numbers = [2, 3, 5, 7, 11, 17, 19]
        for prime in prime_numbers:
            self.assertTrue(is_prime(prime), f"{prime} should be prime")
        
        # Test known non-prime numbers
        non_prime_numbers = [0, 1, 4, 6, 8, 9, 10, 12]
        for non_prime in non_prime_numbers:
            self.assertFalse(is_prime(non_prime), f"{non_prime} should not be prime")
    
    def test_main_function(self):
        """Test the main function's output and return value."""
        # Capture stdout
        captured_output = io.StringIO()
        sys.stdout = captured_output
        
        try:
            # Call main and store its return value
            result = main()
            
            # Get the printed output
            output = captured_output.getvalue().strip().split('\n')
            
            # Verify output
            self.assertEqual(result, "Hello, World!")
            self.assertEqual(output[0], "Hello, World!")
            self.assertEqual(output[1], "Rectangle area: 15")
            self.assertEqual(output[2], "Is 17 prime? True")
        
        finally:
            # Restore stdout
            sys.stdout = sys.__stdout__

if __name__ == "__main__":
    unittest.main()
