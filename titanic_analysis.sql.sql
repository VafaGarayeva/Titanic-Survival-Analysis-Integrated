SELECT P_SEX, P_CLASS, 
       COUNT(*) as Cemi_Sernisin,
       SUM(SURVIVED) as Sag_Qalanlar,
       ROUND(AVG(SURVIVED) * 100, 2) || '%' as Sag_Qalma_Faizi
FROM TITANIC_DATA
GROUP BY P_SEX, P_CLASS
ORDER BY P_SEX, P_CLASS;
---Gender Primacy: 97% of 1st Class women survived vs. only 13% of 3rd Class men, proving gender was the strongest survival factor.

---Wealth Privilege: 1st Class men had 3x higher survival odds (37%) than 3rd Class men (13%).

--Social Hierarchy: Even 3rd Class women (50%) outperformed 1st Class men (37%), validating the "Women First" rule.

--Key Takeaway: Survival was a rigid hierarchy defined by gender priority and class privilege.

SELECT 
    CASE 
        WHEN P_NAME LIKE '%Lady%' OR P_NAME LIKE '%Sir%' OR P_NAME LIKE '%Countess%' OR P_NAME LIKE '%Mme%' THEN 'Elite (Aristocrat)'
        WHEN P_NAME LIKE '%Mr.%' THEN 'Ordinary Man'
        ELSE 'Other Titles'
    END AS Social_Status,
    ROUND(AVG(FARE), 2) as Orta_Bilet_Qiymeti,
    ROUND(AVG(SURVIVED) * 100, 2) || '%' as Sag_Qalma_Faizi
FROM TITANIC_DATA
GROUP BY 
    CASE 
        WHEN P_NAME LIKE '%Lady%' OR P_NAME LIKE '%Sir%' OR P_NAME LIKE '%Countess%' OR P_NAME LIKE '%Mme%' THEN 'Elite (Aristocrat)'
        WHEN P_NAME LIKE '%Mr.%' THEN 'Ordinary Man'
        ELSE 'Other Titles'
    END
ORDER BY AVG(SURVIVED) DESC;
--Elite Survival: Aristocratic titles (Lady, Sir) achieved a 66.67% survival rate, nearly quadruple that of ordinary men.

--Fare Gap: Elite passengers paid an average of 44.66, almost double the "Ordinary Man" group (24.51).

--Title Power: "Other Titles" maintained a high 69.46% survival, confirming that social standing was a primary shield.
SELECT (SIBSP + PARCH + 1) AS Family_Size,
       COUNT(*) AS Total,
       ROUND(AVG(SURVIVED) * 100, 2) || '%' AS Survival_Rate
FROM TITANIC_DATA
GROUP BY (SIBSP + PARCH + 1)
ORDER BY Family_Size;
--Optimal Size: Survival peaks at 57.84% for a family size of 3, validating the "Small Family" advantage shown in Tableau.

--Solo Risks: Solo travelers had a significantly lower survival rate of 30.35%.

--Large Family Struggles: As family size increases beyond 4, survival rates drop sharply (e.g., 13.64% for size 6), as larger groups struggled to stay together
SELECT P_SEX, 
       CASE WHEN P_AGE < 18 THEN 'Usaq' ELSE 'Boyuk' END as Yas_Kateqoriyasi,
       ROUND(AVG(SURVIVED) * 100, 2) || '%' as Sag_Qalma
FROM TITANIC_DATA
WHERE P_AGE IS NOT NULL
GROUP BY P_SEX, CASE WHEN P_AGE < 18 THEN 'Usaq' ELSE 'Boyuk' END
ORDER BY P_SEX;
--Gender Over Age: Age did not matter because gender was the ultimate priority. Adult females had a significantly higher survival rate (77.18%) than male children (39.66%).
--Statistical Insight: The insignificance of age in SPSS ($p=0.997$) is proven here; "Women First" was such a rigid rule that it even superseded the priority of saving children of the opposite sex.
--Male Sacrifice: Adult males faced the most extreme survival barrier at only 17.72%, regardless of age.
SELECT P_SEX, P_CLASS, EMBARKED, 
       COUNT(*) as Say,
       ROUND(AVG(SURVIVED) * 100, 2) || '%' as Sag_Qalma_Faizi
FROM TITANIC_DATA
GROUP BY P_SEX, P_CLASS, EMBARKED
HAVING COUNT(*) > 10
ORDER BY AVG(SURVIVED) DESC;
---The "Untouchables": The highest survival rate (97.67%) belonged to 1st Class Females from Cherbourg (C), proving that the intersection of female gender, top-tier class, and wealthy embarkation ports created near-perfect odds.
---The "Sacrificed": The lowest survival rate (7.69%) was found among 3rd Class Males from Queenstown (Q), representing the most vulnerable group in the disaster.
---Port Influence: Cherbourg (C) consistently shows higher survival across classes compared to Southampton (S), reinforcing the Tableau insight that wealthier passengers boarded there.