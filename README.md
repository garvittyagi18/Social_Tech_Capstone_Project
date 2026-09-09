# Project Topic 04

# SocialTech Project: Analyse Social Media Engagement to Uncover Brand Performance Insights

## Case Study Description
To analyze social media engagement metrics and identify the content types and posting strategies that enhance brand visibility and audience interaction.

---

## Dataset Description

### 1. audience_demographic.csv  
**Total Records:** 49,654  
Contains demographic distribution of audiences linked to each creator.  
- **audience_id**: Unique identifier for audience record  
- **creator_id**: Foreign key linking to creator table  
- **audience_age_distribution**: Age group (e.g., 19–25, 26–35)  
- **audience_gender_distribution**: Gender category (male, female, non-binary)  
- **audience_location**: Geographic location of audience  


---

### 2. creator.csv  
**Total Records:** 5,000  
Contains creator profile information.  
- **creator_id**: Unique identifier for creator  
- **creator_name**: Creator’s username  
- **platform**: Social media platform (e.g., YouTube, Bilibili, RedNote)  
- **follower_count**: Number of followers  
- **audience_location**: Primary audience location  


---

### 3. engagement.csv  
**Total Records:** 52,214  
Captures engagement metrics for each post.  
- **engagement_id**: Unique identifier for engagement record  
- **content_id**: Foreign key linking to post table  
- **views**: Number of views  
- **likes**: Number of likes  
- **shares**: Number of shares  
- **comments_count**: Number of comments  
- **comments_text**: Text of comments  


---

### 4. post.csv  
**Total Records:** 52,214  
Contains metadata for each post.  
- **content_id**: Unique identifier for post  
- **creator_id**: Foreign key linking to creator table  
- **content_url**: URL of the post  
- **content_type**: Type of content (video, image, text)  
- **content_category**: Category (beauty, lifestyle, tech, etc.)  
- **post_date**: Date and time of posting  
- **language**: Language of content  
- **content_length**: Length of content (characters/words)  
- **content_description**: Text description of the post  

---

### 5. sponsorship.csv  
**Total Records:** 22,314  
Contains sponsorship and brand collaboration details.  
- **sponsorship_id**: Unique identifier for sponsorship record  
- **content_id**: Foreign key linking to post table  
- **disclosure_type**: Explicit or implicit disclosure  
- **sponsor_name**: Name of sponsoring brand  
- **sponsor_category**: Category of sponsor (travel, food, cosmetics, fashion, etc.)  
- **disclosure_location**: Where sponsorship disclosure appears (hashtags, caption, video)  


---

##  Notes
- All tables are linked via **creator_id** and **content_id** foreign keys.  
- Derived fields (e.g., Engagement Rate, Hashtag Density, Sponsorship Intensity) can be calculated during analysis.  
- This dataset supports **SQL, Python, Power BI EDA, hypothesis testing, probability, and sampling exercises** for marketing and social media analytics.


