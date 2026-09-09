/*
Trigger: Auto-Append "#Sponsored" to Post Hashtags
The Situation: Legal compliance is critical in influencer marketing. If a sponsorship is logged for a specific post, 
the post must disclose it. This trigger runs automatically whenever a new deal is added to the ⁠sponsorship⁠ table.
 It checks the linked ⁠post⁠ and appends ⁠#sponsored⁠ to the ⁠hashtags⁠ column if it isn't already there.
*/

DELIMITER //

CREATE TRIGGER after_sponsorship_insert
AFTER INSERT ON sponsorship
FOR EACH ROW
BEGIN
    -- Update the linked post to ensure the hashtag exists
    UPDATE post
    SET hashtags = CONCAT(IFNULL(hashtags, ''), ' #sponsored')
    WHERE content_id = NEW.content_id
      AND (hashtags NOT LIKE '%#sponsored%' OR hashtags IS NULL);
END//

DELIMITER ;

/*
Trigger: Data Integrity Check on Engagement Metrics
The Situation: Sometimes API glitches or human errors result in impossible data being imported—for example, 
a post having 5,000 likes but only 100 views. This preventative trigger fires before any new row is added to
 the ⁠engagement⁠ table and blocks the insertion if the math is impossible.
*/

DELIMITER //

CREATE TRIGGER before_engagement_insert
BEFORE INSERT ON engagement
FOR EACH ROW
BEGIN
    -- Prevent illogical engagement data where actions exceed total views
    IF NEW.likes > NEW.views OR NEW.shares > NEW.views OR NEW.comments_count > NEW.views THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Data Error: Likes, shares, or comments cannot exceed total views.';
    END IF;
END//

DELIMITER ;

/*
Stored Procedure: Creator Impact & Sponsorship Summary
The Situation: You need a quick, reliable way to pull a summary report for any creator without writing complex ⁠
JOIN⁠ statements every single time. This stored procedure accepts a ⁠creator_id⁠ as input and joins the ⁠creator⁠,
 ⁠post⁠, ⁠engagement⁠, and ⁠sponsorship⁠ tables to return their total footprint.
*/

DELIMITER //

CREATE PROCEDURE GetCreatorImpactReport(IN input_creator_id INT)
BEGIN
    SELECT 
        c.creator_name,
        c.platform,
        COUNT(DISTINCT p.content_id) AS total_posts,
        IFNULL(SUM(e.views), 0) AS total_views,
        IFNULL(SUM(e.likes), 0) AS total_likes,
        COUNT(DISTINCT s.sponsorship_id) AS total_sponsored_deals
    FROM creator c
    LEFT JOIN post p ON c.creator_id = p.creator_id
    LEFT JOIN engagement e ON p.content_id = e.content_id
    LEFT JOIN sponsorship s ON p.content_id = s.content_id
    WHERE c.creator_id = input_creator_id
    GROUP BY c.creator_id, c.creator_name, c.platform;
END//

DELIMITER ;

CALL GetCreatorImpactReport(10);



