"""Test cases for the main module."""

import unittest
from app.main import get_hello_message, main


class TestHelloWorld(unittest.TestCase):
    """Test cases for Hello World functionality."""

    def test_get_hello_message(self):
        """Test that the hello message function returns the expected string."""
        self.assertEqual(get_hello_message(), "Hello, World!")

    def test_main_function(self):
        """Test that the main function returns the expected string."""
        self.assertEqual(main(), "Hello, World!")


if __name__ == "__main__":
    unittest.main()
