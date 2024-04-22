--[[

Question 2
Colter Snyder

Methodology:
    Added query sanitization
      Makes sure that memberCount is a number before attempting
        to pass it on to the query
    Finally, free the memory used by the result

]]--

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

    -- We need to ensure that memberCount is a number
    if type(memberCount) == 'number' then
        local resultID = db.storeQuery(string.format(selectGuildQuery, memberCount))

        -- Ensure the query returned results
        if not resultID then
            print("There are no guilds smaller than " .. memberCount .. ".")
            return
        end

        -- Get the guild name from the result
        local guildName = result.getString(resultID, "name")
        print(guildName)

        -- Free the memory from our query result
        result.free(resultID)
    else
        print("Not a proper guild")
    end
end