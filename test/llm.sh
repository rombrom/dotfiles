#!/bin/sh

# Test script for LLM wrapper
# This tests that the ,llm script properly receives responses from an LLM

echo "Testing LLM wrapper script..."

# Add the directory containing our script to PATH temporarily
export PATH="$PATH:$(pwd)/dotfiles/misc/.local/bin"

# Test 1: Basic functionality - should return some response (with stdin)
echo "Test 1: Basic functionality with stdin"
result=$(cat $(pwd)/test/simple.fixture.txt | ,llm "Summarize this content")
echo "Response received (first 200 chars): ${result#*\"content\":\"}" | head -c 200

# Test 2: Check if we get a non-empty response
echo "\nTest 2: Response validation with stdin"
if [ -n "$result" ]; then
    echo "✓ Script executed successfully and returned a response"
else
    echo "✗ Script did not return any response"
    exit 1
fi

# Test 3: Test with different query (with stdin)
echo "\nTest 3: Different query with stdin"
result2=$(cat $(pwd)/test/simple.fixture.txt | ,llm "What is this file about?")
if [ -n "$result2" ]; then
    echo "✓ Second query also returned a response"
else
    echo "✗ Second query did not return any response"
    exit 1
fi

# Test 4: Query without passing stdin (direct query)
echo "\nTest 4: Direct query without stdin"
result3=$(echo "" | ,llm "What is the capital of France?")
if [ -n "$result3" ]; then
    echo "✓ Direct query without stdin returned a response"
    echo "Response received (first 200 chars): ${result3#*\"content\":\"}" | head -c 200
else
    echo "✗ Direct query without stdin did not return any response"
    exit 1
fi

echo "\nAll tests completed successfully!"
