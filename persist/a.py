import discord
import io
import chat_exporter
from discord.ext import commands

client = discord.Client()
@client.event
async def on_ready():
    guild = client.get_guild(1095719790745755688)
    stoa = discord.utils.get(guild.channels, name="stoa")
    save = await chat_exporter.export(
        stoa,
        total=145925)
    print(save, file=open("transcript.html","w"))

client.run("MTIxMDI2MDM2NDQxNjEyMjk2MQ.GPpPC9.JHoVTESqSsY4CpIYCzqWpYgUkApEMeSHl1v1is")
