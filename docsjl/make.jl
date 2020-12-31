using Documenter, Pkg
pkg"activate .."
using MolecBio

makedocs(
sitename = "MolecBio.jl",
modules = [MolecBio])
