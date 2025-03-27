def get_hello_message() -> str:
    """Return a hello world message."""
    return "Hello, World!"


def main() -> str:
    """Main function to print the hello message."""
    message = get_hello_message()
    print(message)
    return message


if __name__ == "__main__":
    main()
