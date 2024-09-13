# Bitbucket PR Fetcher Script

## Description

This script retrieves merged pull requests from a specific Bitbucket repository where a specified user was a reviewer within the last month. It uses the Bitbucket API to fetch the pull requests and outputs their IDs, titles, authors, and links to the pull request.

## Prerequisites

Before running this script, you need:
- **Bitbucket Username**: Your Bitbucket account username.
- **Bitbucket App Password**: You can generate this from Bitbucket under **Personal Settings > App Passwords**.
- **jq**: A lightweight command-line JSON processor. Install it using the package manager for your system (e.g., `brew install jq` on macOS or `sudo apt install jq` on Ubuntu).
  
## Script Details

This script uses the Bitbucket API to:
- Get all merged pull requests from the repository.
- Filter those where the specified reviewer was involved.
- Only return pull requests merged within the last month.

## How to Use

### 1. Configure the Script
Edit the script and replace the following placeholders with your actual details:

- `BITBUCKET_USERNAME`: Your Bitbucket username.
- `BITBUCKET_APP_PASSWORD`: Your Bitbucket app password.
- `WORKSPACE`: The workspace where the repository is hosted.
- `REPOSITORY`: The name of the repository.
- `REVIEWER_USERNAME`: The Bitbucket username of the reviewer you are tracking.

```bash
# Replace these with your Bitbucket credentials and repository details
BITBUCKET_USERNAME="your-bitbucket-username"
BITBUCKET_APP_PASSWORD="your-app-password"
WORKSPACE="your-workspace"
REPOSITORY="your-repo-name"
REVIEWER_USERNAME="reviewer-username"
```

### 2. Run the Script

Ensure you have given the script execution permission. You can do this by running:

```bash
chmod +x script.sh
```

Then run the script:

```bash
./script.sh
```

### 3. Example Output

```text
123: Fix bug in authentication by John Doe - https://bitbucket.org/workspace/repo-name/pull-requests/123
456: Add new feature by Jane Smith - https://bitbucket.org/workspace/repo-name/pull-requests/456
```

Each line of the output contains:
- The PR ID.
- The title of the PR.
- The author of the PR.
- A link to view the PR on Bitbucket.

## How It Works

1. **Fetch Date**: The script calculates the date one month ago from the current date using the `date` command.
   - For macOS and BSD systems, the command is `date -u -v -1m +"%Y-%m-%dT%H:%M:%SZ"`.
   
2. **URL Construction**: The API URL is built with encoded query parameters to ensure special characters don't cause issues.

3. **API Request**: The script uses `curl` to make an authenticated API request to Bitbucket, fetching the merged pull requests.

4. **JSON Processing**: The response is parsed using `jq` to extract relevant information about the pull requests, such as their ID, title, author, and link.

## Troubleshooting

### Common Issues:
- **jq command not found**: Make sure `jq` is installed and available in your system’s PATH.
- **Authentication failed**: Double-check your Bitbucket username and app password.

### Error Handling:
If you encounter issues such as invalid API responses or permission errors, ensure your app password has the necessary permissions for pull requests.

## License

This script is provided "as-is" without any warranty. You are free to modify and distribute it as per your needs.

---

By using this script, you acknowledge that you have permission to access the Bitbucket repository and review pull requests for the specified user.