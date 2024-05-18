---
permalink: /cgi/kernelstats/index.sh
---

R_6_9=1
R_6_8=10
R_6_6=31
R_6_1=91
R_5_15=159
R_5_10=217
R_5_4=276
R_4_19=314

# 6.9. series
for REALAESE in `seq 1 ${R_6_9}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-6.9.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-6.9.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.9.${REALAESE}"
    fi
done

# 6.8. series
for REALAESE in `seq 1 ${R_6_8}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-6.8.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-6.8.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.8.${REALAESE}"
    fi
done

# 6.6. series
for REALAESE in `seq 1 ${R_6_6}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-6.6.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-6.6.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.6.${REALAESE}"
    fi
done

# 6.1. series
for REALAESE in `seq 1 ${R_6_1}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-6.1.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-6.1.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.${REALAESE}"
    fi
done

# 5.15. series
for REALAESE in `seq 1 ${R_5_15}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-5.15.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-5.15.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.15.${REALAESE}"
    fi
done

# 5.10. series
for REALAESE in `seq 1 ${R_5_10}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-5.10.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-5.10.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.10.${REALAESE}"
    fi
done

# 5.4. series
for REALAESE in `seq 1 ${R_5_4}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-5.4.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-5.4.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.4.${REALAESE}"
    fi
done

# 4.19. series
for REALAESE in `seq 1 ${R_4_19}`; do
    if [ ! -f "{{ site.data_dir }}kernelstats/ChangeLog-4.19.${REALAESE}" ]; then
        wget -O "{{ site.data_dir }}kernelstats/ChangeLog-4.19.${REALAESE}" \
        "https://cdn.kernel.org/pub/linux/kernel/v4.x/ChangeLog-4.19.${REALAESE}"
    fi
done

echo "Content-type: text/plain; charset=utf-8"
echo ""

for VERSION in "6.9.${R_6_9}" "6.8.${R_6_8}" "6.6.${R_6_6}" "6.1.${R_6_1}" "5.15.${R_5_15}" "5.10.${R_5_10}" "5.4.${R_5_4}" "4.19.${R_4_19}" ; do
    echo "<h2>Sum of all contributions from release $(echo ${VERSION} | cut -d "." -f1).$(echo ${VERSION} | cut -d "." -f2).1 to ${VERSION}</h2>"
    echo ""
    echo "<pre>"
    cat {{ site.data_dir  }}kernelstats/ChangeLog-$(echo ${VERSION} | cut -d "." -f1).$(echo ${VERSION} | cut -d "." -f2).* | \
    grep 'Author' | \
    cut -d':' -f2 | \
    sort | \
    uniq -c | \
    sed 's/^[ \t]*//' | \
    sort -nr | \
    head -n 50 | \
    sed 's@<@\&lt;@g' | \
    sed 's@>@\&gt;@g'
    echo "</pre>"
    echo ""
done

