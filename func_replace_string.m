function func_replace_string(InputFile, OutputFile, SearchString, ReplaceString,offset)
% InputFile - string
% OutputFile - string
% SearchString - string
% ReplaceString - string
% read whole model file data into cell array

fid = fopen(InputFile);
data = textscan(fid, '%s', 'Delimiter', '\n', 'CollectOutput', true);
fclose(fid);
% modify the cell array
% find the position where changes need to be applied and insert new data
for I = 1:length(data{1})
    tf = contains(data{1}{I}, SearchString); % search for this string in the array
    if tf == 1
        data{1}{I+offset} = ReplaceString; % replace with this string
    end
end
% write the modified cell array into the text file
fid = fopen(OutputFile, 'w');
for I = 1:length(data{1})
    fprintf(fid, '%s\n', char(data{1}{I}));
end
fclose(fid);