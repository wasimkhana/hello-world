def get_hello_message() -> str:
    """Return a hello world message."""
    return "Hello, World!"

def calculate_rectangle_area(length: float, width: float) -> float:
    """
    Calculate the area of a rectangle.
    
    Args:
        length (float): Length of the rectangle
        width (float): Width of the rectangle
    
    Returns:
        float: Area of the rectangle
    """
    if length < 0 or width < 0:
        raise ValueError("Dimensions cannot be negative")
    return length * width

def is_prime(number: int) -> bool:
    """
    Check if a given number is prime.
    
    Args:
        number (int): Number to check for primality
    
    Returns:
        bool: True if the number is prime, False otherwise
    """
    if number < 2:
        return False
    for i in range(2, int(number**0.5) + 1):
        if number % i == 0:
            return False
    return True

def main() -> str:
    """Main function to demonstrate various operations."""
    message = get_hello_message()
    print(message)
    
    # Demonstrate rectangle area calculation
    rect_area = calculate_rectangle_area(5, 3)
    print(f"Rectangle area: {rect_area}")
    
    # Demonstrate prime number check
    prime_check = is_prime(17)
    print(f"Is 17 prime? {prime_check}")
    
    return message

if __name__ == "__main__":
    main()
