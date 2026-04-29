function extract --description 'Extract common archives: extract <archive> [destination]'
    if test (count $argv) -eq 0 -o (count $argv) -gt 2
        echo 'usage: x <archive> [destination]' >&2
        return 1
    end

    set -l archive $argv[1]
    set -l dest .
    test (count $argv) -eq 2; and set dest $argv[2]

    if not test -f "$archive"
        echo "x: file not found: $archive" >&2
        return 1
    end

    mkdir -p -- "$dest"; or return 1

    set -l archive_name (basename -- "$archive")
    set -l lower_name (string lower -- "$archive_name")
    set -l output_path

    switch $lower_name
        case '*.tar.zst' '*.tzst'
            type -q zstd; or begin; echo 'x: zstd is required for .tar.zst archives' >&2; return 1; end
            zstd -dc -- "$archive" | tar -xf - -C "$dest"
        case '*.tar.gz' '*.tgz' '*.tar.bz2' '*.tbz' '*.tbz2' '*.tar.xz' '*.txz' '*.tar'
            tar -xf "$archive" -C "$dest"
        case '*.zip'
            unzip -q "$archive" -d "$dest"
        case '*.7z'
            type -q 7z; or begin; echo 'x: 7z is required for .7z archives' >&2; return 1; end
            7z x -y "-o$dest" "$archive"
        case '*.rar'
            if type -q 7z
                7z x -y "-o$dest" "$archive"
            else if type -q unar
                unar -q -o "$dest" "$archive"
            else
                echo 'x: need 7z or unar for .rar archives' >&2
                return 1
            end
        case '*.gz' '*.bz2' '*.xz' '*.zst'
            set output_path "$dest/"(string replace -r '\.(gz|bz2|xz|zst)$' '' -- "$archive_name")
            test "$dest" = .; and set output_path (string replace -r '\.(gz|bz2|xz|zst)$' '' -- "$archive_name")
            if test -e "$output_path"
                echo "x: output already exists: $output_path" >&2
                return 1
            end
            switch $lower_name
                case '*.gz'
                    gunzip -kc -- "$archive" > "$output_path"
                case '*.bz2'
                    bunzip2 -kc -- "$archive" > "$output_path"
                case '*.xz'
                    if type -q xz
                        xz -dc -- "$archive" > "$output_path"
                    else if type -q unxz
                        unxz -kc -- "$archive" > "$output_path"
                    else
                        echo 'x: xz or unxz is required for .xz archives' >&2
                        return 1
                    end
                case '*.zst'
                    type -q zstd; or begin; echo 'x: zstd is required for .zst archives' >&2; return 1; end
                    zstd -dc -- "$archive" > "$output_path"
            end
        case '*'
            echo "x: unsupported archive format: $archive" >&2
            return 1
    end
end
