function writeTableToDocument(tableData, headerLabels, d,varName)
    import mlreportgen.dom.*
   
    
    % Define table styles
    tableStyles = {NumberFormat('%1.1f'),...
                   ColSep('solid'), ...
                   RowSep('solid'), ...
                   Border('solid')};
                
    tableHeaderStyles = {BackgroundColor('lightgray'), ...
                         Bold(true),...
                         FontSize('10pt')};

    % Create the formal table
    cellTbl = FormalTable(headerLabels, tableData);
    cellTbl.Style = [cellTbl.Style, tableStyles];
    cellTbl.Header.Style = [cellTbl.Header.Style, tableHeaderStyles];
    cellTbl.TableEntriesInnerMargin = '2pt';
    
    % write table name
    append(d, Paragraph(varName));
    append(d, Paragraph(" "));

    % Append the table
    append(d, cellTbl);

    % Add an empty line
    append(d, Paragraph(" "));
    varName
end