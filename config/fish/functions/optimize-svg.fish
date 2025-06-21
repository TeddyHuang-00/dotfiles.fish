function optimize-svg -d "Optimize SVG files" -a svg_file
    # Check if the file is provided and exists
    if test (count $argv) -ne 1
        echo "Usage: optimize-svg <svg-file>"
        return 1
    end

    # Check if the file exists
    if not test -f "$svg_file"
        echo "File not found: $svg_file"
        return 1
    end

    # Check if the file is an SVG
    if not string match -q "*.svg" "$svg_file"
        echo "Error: $svg_file is not an SVG file."
        return 1
    end

    # Check if scour and svgo are installed
    if not type -q scour
        echo "Error: scour command not found. Install with: pip install scour"
        return 1
    end
    if not type -q svgo
        echo "Error: svgo command not found. Install with: npm install -g svgo"
        return 1
    end

    # Create a temporary directory for processing
    set temp_dir (mktemp -d -t optimize-svg)
    set temp_svg_file "$temp_dir/$svg_file"
    # First pass
    scour "$svg_file" "$temp_svg_file" --enable-id-stripping --shorten-ids
    # Second pass
    scour "$temp_svg_file" "$svg_file" --create-groups --remove-descriptive-elements
    # Final pass to ensure the SVG is optimized
    svgo --multipass "$svg_file"
    # Clean up
    rm -rf "$temp_dir"
end
