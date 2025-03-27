from typing import Any

import pytest

from app.main import get_hello_message, main

def test_get_hello_message_default() -> None:
    """
    Test default hello message.
    """
    assert get_hello_message() == "Hello, World!"

def test_get_hello_message_with_name() -> None:
    """
    Test hello message with a name.
    """
    assert get_hello_message("Alice") == "Hello, Alice!"

def test_main(capsys: Any) -> None:
    """
    Test main function output and return value.
    """
    result = main()
    assert result == 0
    captured = capsys.readouterr()
    assert captured.out.strip() == "Hello, World!"
