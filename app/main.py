from typing import Optional, Union

def get_hello_message(name: Optional[str] = None) -> str:
    """
    Generate a greeting message.
    
    Args:
        name: Optional name to include in the greeting.
    
    Returns:
        A greeting string.
    """
    if name:
        return f"Hello, {name}!"
    return "Hello, World!"

def main() -> int:
    """
    Main application entry point.
    
    Returns:
        Exit code (0 for success).
    """
    message = get_hello_message()
    print(message)
    return 0

if __name__ == "__main__":
    main()
