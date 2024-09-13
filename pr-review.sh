#!/bin/bash

# Replace these with your Bitbucket credentials and repository details
BITBUCKET_USERNAME="bitbucket-username"
BITBUCKET_APP_PASSWORD="app-password"
WORKSPACE="workspace-name"
REPOSITORY="repo-name"
REVIEWER_USERNAME="bitbucket-username"

# Date one month ago in ISO 8601 format (using macOS/BSD date command)
DATE_ONE_MONTH_AGO=$(date -u -v -1m +"%Y-%m-%dT%H:%M:%SZ")

# Encode the query parameters to avoid issues with special characters
ENCODED_DATE=$(printf '%s' "$DATE_ONE_MONTH_AGO" | jq -sRr @uri)
ENCODED_REVIEWER=$(printf '%s' "$REVIEWER_USERNAME" | jq -sRr @uri)

# Construct the API URL to search for merged pull requests
API_URL="https://api.bitbucket.org/2.0/repositories/$WORKSPACE/$REPOSITORY/pullrequests?q=updated_on>%22$ENCODED_DATE%22%20AND%20reviewers.username%3D%22$ENCODED_REVIEWER%22%20AND%20state%3D%22MERGED%22"

# Fetch merged pull requests where you were a reviewer within the last month
curl -u "$BITBUCKET_USERNAME:$BITBUCKET_APP_PASSWORD" "$API_URL" | jq -r '.values[] | "\(.id): \(.title) by \(.author.display_name) - \(.links.html.href)"'
