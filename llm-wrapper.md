# LLM Wrapper Script Plan

## Overview

Create a POSIX shell script called `,llm` in `dotfiles/misc/.local/bin` that takes stdin as context and one command line argument as the query, then outputs an LLM response. This will use a simple curl-based approach for local LLM communication.

## Requirements

1. Accept input from stdin (as context)
2. Accept one command line argument (the query)
3. Output LLM response to stdout
4. Written in POSIX shell for maximum portability
5. No configuration files, environment variables, or complex setup
6. No sub-agents or caching
7. Only supports local LLM endpoints

## Architecture

### Input/Output Handling

- Read all stdin into a variable (context)
- Take command line argument as the query
- Combine context and query for LLM processing
- Use curl to communicate with local LLM endpoint
- Output raw LLM response to stdout

### Tool Call Support

- Parse tool calls from LLM responses (using JSON parsing)
- Execute identified tools using shell commands, with bash as the primary supported tool
- Return tool results back to LLM by sending a new message with the results
- Support multiple tool calls in a single response
- Handle recursive tool call scenarios where tool execution may produce additional tool calls
- Graceful error handling for failed tool executions
- Bash tool specifically allows LLM to read files and make edits using available shell tooling

## Implementation Approach

### Core Script Structure

1. Parse command line arguments (first argument is query)
2. Read stdin into a variable (context)
3. Combine context and query into messages structure for LLM processing
4. Send request via curl to local LLM endpoint with proper JSON format
5. If tool calls are detected in response, execute them and send results back to LLM
6. Output raw LLM response (after all tool calls are processed)

## Technical Considerations

### Context and Query Handling

- stdin will be treated as context (e.g., code block)
- command line argument will be the user's query
- Combine both into proper messages structure for LLM processing

### Implementation Details

- Use curl to communicate with local LLM endpoint (default: http://localhost:8484/v1/chat/completions)
- Minimal error handling
- Keep implementation simple and portable
- No configuration files or environment variables

## Usage Examples

The script will be used in patterns like:

```
cat file.py | ,llm "Explain this code"
echo "What is this?" | ,llm "Summarize the following code block"
```

## Expected Interface

The script should:

- Accept stdin as context
- Accept one command line argument as query
- Use curl to communicate with a local LLM endpoint (default: http://localhost:11434/v1/chat/completions)
- Output raw response from LLM
- Handle errors gracefully without configuration files or environment variables

Example usage:

```
cat myfile.txt | ,llm "What does this do?"
```

## Parameters to Support

For the basic implementation, we'll support these key parameters:

- messages: context + query combined as user message
- model: hardcoded for local LLM (e.g., "llama3")
- max_completion_tokens: 150
- temperature: 0.5
- top_p: 0.8

## Implementation Notes

This script will be a minimal wrapper that:

1. Reads stdin as context
2. Takes the command line argument as query
3. Combines them into a structured message for the LLM
4. Sends to a local endpoint via curl with proper JSON format
5. If tool calls are detected in response, executes them and sends results back to LLM
6. Outputs the raw response from the LLM (after all tool calls are processed)

Tool Call Processing Details:

- Parse JSON response for tool call objects using jq or similar
- Execute tools sequentially using shell commands, with bash as primary tool
- Handle errors gracefully - if a tool fails, continue with other tools or return error to user
- Submit tool results back to LLM via additional message in the conversation
- Support iterative processing until no more tool calls are present
- Bash tool specifically enables file reading and editing capabilities
