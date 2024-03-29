# 2024 USA Election Prediction
## Overview
This paper uses multilevel regression with post-stratification to predict the outcome between the two candidates, Biden and Trump. The prediction suggests that Biden is poised to secure a substantial lead of at least 10% in popular vote. Broader context and limitations are also discussed in this paper. In this repo, APP is short for America's Political Pulse. 
- The sample dataset could be found here https://polarizationresearchlab.org/americas-political-pulse/
- The census dataset could be found here https://usa.ipums.org/usa/
- The 2020 Actual Votes could be found here: https://www.kaggle.com/datasets/unanimad/us-election-2020?resource=download

These datasets are in `inputs` file and are added in .gitignore, so both the file and the datasets are not shown in this repo.

## File Structure
The repo is structured as:
-   `outputs` contains the files used to generate the paper, including the Quarto document and reference bibliography, as well as the PDF of the paper. Two models are also contained in this file.
-   `scripts` contains the R scripts used to simulate, download, cleanand test the data.
-   `LLM` contains the link and text of the conversations in ChatGpt.
-   `sketches` contains the sketches of datasets and visualizations before using the actual datasets.

## Packages Installization
The codes used to install packages are in `scripts/01-download.R`, with `#` before each code.

## LLM Usage
ChatGpt was used for correcting grammar and modifying the codes. It helped improve writings and codes. The chat can be found in LLM/llm.txt. No other LLM was used.
