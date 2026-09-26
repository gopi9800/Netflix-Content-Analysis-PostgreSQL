# Netflix Content Analysis — PostgreSQL

## Overview

This project uses PostgreSQL to analyze a Netflix content dataset
containing movies and TV shows.

The analysis focuses on content types, ratings, countries, genres,
directors, actors, release years, and content availability trends.

## Business Objectives

The project addresses business questions related to:

- Movies vs TV shows
- Common content ratings
- Content production by country
- Genre distribution
- Content release trends
- Directors and actors
- TV shows with multiple seasons
- Missing director information
- Indian content
- Content categorization based on description keywords

## Analysis Performed

### Content Analysis

- Count of Movies vs TV Shows
- Most common rating by content type
- Movies released in a specific year
- Longest movie
- TV shows with more than five seasons
- Content added within a specified time period

### Geographic Analysis

- Top countries producing Netflix content
- Indian content analysis
- Content trends associated with India

### Genre Analysis

- Number of titles in each genre
- Documentary movie analysis
- Genre-level content distribution

### Actor & Director Analysis

- Content by specific directors
- Actor appearances
- Top actors in Indian-produced content
- Content without director information

### Content Classification

- Keyword-based classification using descriptions
- Identification of content containing keywords such as
  "kill" and "violence"

## SQL Techniques Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- LIMIT
- Aggregate Functions
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- UNNEST()
- STRING_TO_ARRAY()
- SPLIT_PART()
- ILIKE
- CASE Statements
- Type Casting
- Date Conversion
- Date Arithmetic
- EXTRACT()
- String Manipulation

## Database Structure

The project uses a `netflix` table containing fields related to:

- Show ID
- Content Type
- Title
- Director
- Cast
- Country
- Date Added
- Release Year
- Rating
- Duration
- Genre
- Description

## Tools

- PostgreSQL
- pgAdmin
